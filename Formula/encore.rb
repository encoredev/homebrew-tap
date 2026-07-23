class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.13"
    checksums = {
        "darwin_arm64" => "d610f3af804a4e9e3a67316ff30a625fb14f660cfdea8fe088f218919e5f2918",
        "darwin_amd64" => "4c02cbc67ded7887270d9860229e615be41e1967c0f4797e55dead35455ebbd5",
        "linux_arm64"  => "41ca89aa9d8578572f637ebb71a33eb1357ca75430eefd4e4fcdead123cfa833",
        "linux_amd64"  => "61391dea8e9d7fe8729d0633240f51f57a5af523bab4d2c1b03782a08ff12be9",
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
