class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.2"
    checksums = {
        "darwin_arm64" => "72712a3263a0b118c42fa2b709eca9b61ef1fdcbe58a2e2cf140e982d870db56",
        "darwin_amd64" => "98f20e8dbb4adfb5a7e13c5846e3d84490c555be6a6bb203afcc4e93d4cb0ba3",
        "linux_arm64"  => "dc319e908d4e28f0f526e76ce13b70306a5cbb96344e7420315040a07b7fe666",
        "linux_amd64"  => "88bc0404b978932b5bca71a3853da5c4430ff42f6b917a50abf1a5da435a4e83",
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
