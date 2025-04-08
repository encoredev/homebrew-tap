class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.17"
    checksums = {
        "darwin_arm64" => "c2a42975b4dd71ba1e0922756b7c03178594a39d3d205b8bd5c5c67ec3c620ee",
        "darwin_amd64" => "06a4f6d2167a3042d1059fba3b3ba665adb3714d6271e1f4fa8537fe3489c49a",
        "linux_arm64"  => "2607ba1d33a5dd640ea7b7044880b464d66aedb4613b42c3f3c72901c75b48f9",
        "linux_amd64"  => "524e93af0ca3ab3199260c34b9841f78c0000758e110a992732087a93d8c0882",
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
