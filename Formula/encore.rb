class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.6"
    checksums = {
        "darwin_arm64" => "9e6981bd87471c9a389439b3d60d77c2e2fd111fd51c753ba23e1d8cb1dff957",
        "darwin_amd64" => "382a9b93c7e128c54904c3b3d535d83ab174af71203519799e7ce9c8f9ffc556",
        "linux_arm64"  => "e99581f5a151d060b389d2fd5dfce7e1eac2066872b805b8888cc4397d5a52dd",
        "linux_amd64"  => "8858cc6bd5a5b3e67f25414bf8a3dc0b9ad3e5714287d0e4a7f990ee0a6f20a6",
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
