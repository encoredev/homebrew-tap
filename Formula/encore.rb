class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.49.2"
    checksums = {
        "darwin_arm64" => "8ad00cd0d29b70dc43b6652ae5adb6b7ec100730690b018973c33917c6056c5d",
        "darwin_amd64" => "daf5a4aaba85ace541c8c5cf1389a47cc39fffdf91ae407e8902ebb310a0ef8c",
        "linux_arm64"  => "798e90bd2d1e9dee981a0fbbc4d8922e858a90f4dd0123b8d468d1c555275d04",
        "linux_amd64"  => "386b5e92c7c5ee39d9e49ba701b08563675929aef5058ef465021c79e42854d2",
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
