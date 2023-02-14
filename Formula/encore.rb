class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.0"
    checksums = {
        "darwin_arm64" => "67708e5c76ef492e98b58f99d3647e5a1c245f48a08d66050f6b8da5cac93e95",
        "darwin_amd64" => "549ba447e9326a562e0ae822728c4a17f13c62e7976c43eafd3948fda88baa7f",
        "linux_arm64"  => "7a4aaf965eaee70dd0df951172aae25d763ff35462aa0bf24e550744b54bbea7",
        "linux_amd64"  => "bb4bd539ee2a9a758bfaba0ab11868814769fd8bf2d800652e97728c2ac5495d",
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
