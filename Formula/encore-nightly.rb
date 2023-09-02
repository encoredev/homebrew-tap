class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230902"
    checksums = {
        "darwin_arm64" => "06638c297864653cad42f2b8cd5a3b9ea5de2a538932bb9ea77454843b9515c0",
        "darwin_amd64" => "a677340748a57ce57a7a394172ca81d693d4e7b0609aa13967ee76bc4906eab1",
        "linux_arm64"  => "53eec392ef663abe012af07121e7723467ec60828198255b712cbf08f4520c07",
        "linux_amd64"  => "b5f9a3c48a678e93cde9d7b56e77dc19126d741471d658e2930085ea45466e73",
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
