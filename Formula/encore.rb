class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.4"
    checksums = {
        "darwin_arm64" => "85048dded6e48b59f3728246247a58a213e0b1e1da74957cdeb21fc286a4c3a9",
        "darwin_amd64" => "879647f43f6daae33603fb97e42c17ef4511c13d847b7dd89af3bafbb7720d3c",
        "linux_arm64"  => "ce4b2757ef1dd11368425b92a403abf214298af900e82f90c6780113690799a2",
        "linux_amd64"  => "dcdcd327bb756a53886c3830dc957ff239a6f191bc7a0d3dfb7c87943b235e0b",
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
