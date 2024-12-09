class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.0"
    checksums = {
        "darwin_arm64" => "4aa4aba19e27201ee610cf7b54689a7757e1a1f11b4a4ea5ab19e6fded97331d",
        "darwin_amd64" => "7938293a78152713805c1d66e07d1a725f191711f48a45a5719fb6e759ef7f8e",
        "linux_arm64"  => "22f684d05e98abaced4cae6ac8680215fdd8b66f5eda9951d1146972753e0b2d",
        "linux_amd64"  => "6808bdaeb9b010026ccd525e344fe8cfff968c285a55ab2ba4dddfc476566b74",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
